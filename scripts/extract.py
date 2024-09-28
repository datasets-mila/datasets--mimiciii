import argparse
import glob
import gzip
import os
import subprocess
import shutil
import sys

from jug import TaskGenerator


def extract_gzip(archive, output_dir):
    output_file = os.path.join(output_dir, os.path.basename(archive[:-3]))
    with gzip.open(archive, "rb") as gzip_file, \
         open(output_file, "wb") as decompressed_file:
        shutil.copyfileobj(gzip_file, decompressed_file)


def extract_lz4(archive, output_dir):
    archive_filename = os.path.splitext(os.path.basename(archive))[0]
    with open(os.path.join(output_dir, archive_filename), "w") as decompressed_file:
        subprocess.run(["lz4", "-d", archive], stdout=decompressed_file, check=True)


def extract_tar(archive, output_dir):
    is_gzip = archive.endswith(".tar.gz")
    subprocess.run(["tar", ("-z" if is_gzip else ""), "-xf", archive, "-C", output_dir], check=True)


def extract_zip(archive, output_dir):
    subprocess.run(["unzip", "-n", archive, "-d", output_dir], check=True)


@TaskGenerator
def extract_archive(archive, output_dir=None, delete_archive=False):
    print("Extracting [{}]...".format(archive))
    try:
        output_dir = output_dir if output_dir is not None else os.path.dirname(archive)
        if archive.endswith(".tar") or archive.endswith(".tar.gz"):
            extract_tar(archive, output_dir)
        elif archive.endswith(".lz4"):
            extract_lz4(archive, output_dir)
        elif archive.endswith(".gz"):
            extract_gzip(archive, output_dir)
        elif archive.endswith(".zip"):
            extract_zip(archive, output_dir)
        else:
            raise Exception("Unsupported archive type for file [{}]".format(archive))
        print("Extracted [{}] to [{}]".format(archive, output_dir))
    except Exception as exception:
        print("Failed to extract [{}] to [{}]: {}".format(archive, output_dir, exception), file=sys.stderr)
        delete_archive = False

    if delete_archive:
        print("Removing [{}]...".format(archive))
        try:
            subprocess.run(["rm", "--force", archive], check=True)
            print("Removed [{}]".format(archive))
        except Exception as exception:
            print("Failed to remove [{}]: {}".format(archive, exception), file=sys.stderr)

    return archive


@TaskGenerator
def remove_git_files(tasks_results):
    filenames = []
    for result in tasks_results:
        filenames.extend(result)
    filenames.sort()

    for filename in filenames:
        print("Deleting [{}]...".format(filename))
        subprocess.run(["git", "rm", filename], check=True)


parser = argparse.ArgumentParser()
parser.add_argument("glob")
parser.add_argument("--output", default=None)
parser.add_argument("--delete", default=False, action="store_true")
parser.add_argument("--start", default=0, type=int)
parser.add_argument("--end", default=0, type=int)

args = parser.parse_args()

# Get directories lists
directories = glob.glob(args.glob)
directories.sort()

if args.end == 0:
    args.end = len(directories)

archives = []

for directory in directories[args.start:args.end]:
    archives += glob.glob(os.path.join(directory, "*.zip"))
    archives += glob.glob(os.path.join(directory, "*.gz"))
    archives += glob.glob(os.path.join(directory, "*.lz4"))
    archives += glob.glob(os.path.join(directory, "*.tar"))
    archives += glob.glob(os.path.join(directory, "*.tar.gz"))

archives = list(set(archives))
archives.sort()

# If archives is empty, use the results from args.glob
if not archives:
    archives = directories

extract_tasks = [extract_archive(archive, args.output, args.delete) for archive in archives]

# remove_git_files(extract_tasks)
