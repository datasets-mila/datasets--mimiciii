import argparse
import glob
import os
import subprocess
import sys

from jug import TaskGenerator


def compress_zip(relative_in_dir, out_archive, working_directory=None, store_input=False):
    subprocess.run(["zip", out_archive, "-r", relative_in_dir] +
                   (["--compression-method", "store"] if store_input else []),
                   cwd=working_directory,
                   check=True)


@TaskGenerator
def compress_dir(in_dir, out_archive=None, store_input=False, delete_input=False):
    print("Compressing [{}]...".format(in_dir))
    try:
        if in_dir.endswith(os.path.sep):
            in_dir = in_dir[:-1]
        relative_in_dir = os.path.basename(in_dir)
        out_archive = out_archive if out_archive is not None else relative_in_dir
        out_archive += ".zip"
        compress_zip(relative_in_dir, out_archive, os.path.dirname(in_dir) or None, store_input)
        print("Compressed [{}] to [{}]".format(in_dir, out_archive))
    except Exception as exception:
        print("Failed to compress [{}] to [{}]: {}".format(in_dir, out_archive, exception), file=sys.stderr)
        delete_input = False

    if delete_input:
        print("Removing [{}]...".format(in_dir))
        try:
            subprocess.run(["rm", "-r", "--force", in_dir], check=True)
            print("Removed [{}]".format(in_dir))
        except Exception as exception:
            print("Failed to remove [{}]: {}".format(in_dir, exception), file=sys.stderr)

    return in_dir


@TaskGenerator
def remove_git_files(tasks_results):
    directories = []
    for result in tasks_results:
        directories.extend(result)
    directories.sort()

    for directory in directories:
        print("Deleting [{}]...".format(directory))
        subprocess.run(["git", "rm", "-r", directory], check=True)


parser = argparse.ArgumentParser()
parser.add_argument("glob")
parser.add_argument("--output", default=None)
parser.add_argument("--store", default=False, action="store_true")
parser.add_argument("--delete", default=False, action="store_true")
parser.add_argument("--start", default=0, type=int)
parser.add_argument("--end", default=0, type=int)

args = parser.parse_args()

# Get directories lists
directories = glob.glob(args.glob)
directories.sort()

compress_tasks = [compress_dir(in_dir, args.output, args.store, args.delete) for in_dir in directories]

# remove_git_files(compress_tasks)
