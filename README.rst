###########################
MIMIC-III Waveform Database
###########################

`<https://physionet.org/content/mimic3wdb/1.0/>`_

**When using this resource, please cite:**

Moody, B., Moody, G., Villarroel, M., Clifford, G. D., & Silva, I.  (2020).
MIMIC-III Waveform Database (version 1.0). *PhysioNet*.
https://doi.org/10.13026/c2607m.

+-----------+---------------------------------------------------------+
| MLA       | Moody, Benjamin, et al. "MIMIC-III Waveform Database"   |
|           | (version 1.0). *PhysioNet* (2020),                      |
|           | https://doi.org/10.13026/c2607m.                        |
+-----------+---------------------------------------------------------+
| APA       | Moody, B., Moody, G., Villarroel, M., Clifford, G. D.,  |
|           | & Silva, I. (2020). MIMIC-III Waveform Database         |
|           | (version 1.0). *PhysioNet*.                             |
|           | https://doi.org/10.13026/c2607m.                        |
+-----------+---------------------------------------------------------+
| Chicago   | Moody, Benjamin, Moody, George, Villarroel, Mauricio,   |
|           | Clifford, Gari D., and Ikaro Silva. "MIMIC-III Waveform |
|           | Database" (version 1.0). *PhysioNet* (2020).            |
|           | https://doi.org/10.13026/c2607m.                        |
+-----------+---------------------------------------------------------+
| Harvard   | Moody, B., Moody, G., Villarroel, M., Clifford, G. D.,  |
|           | and Silva, I. (2020) 'MIMIC-III Waveform Database'      |
|           | (version 1.0), *PhysioNet*. Available at:               |
|           | https://doi.org/10.13026/c2607m.                        |
+-----------+---------------------------------------------------------+
| Vancouver | Moody B, Moody G, Villarroel M, Clifford G D, Silva I.  |
|           | MIMIC-III Waveform Database (version 1.0). PhysioNet.   |
|           | 2020. Available from: https://doi.org/10.13026/c2607m.  |
+-----------+---------------------------------------------------------+

**Additionally, please cite the original publication:**

`Johnson, A. E. W., Pollard, T. J., Shen, L., Lehman, L. H., Feng, M.,
Ghassemi, M., Moody, B., Szolovits, P., Celi, L. A., & Mark, R.  G. (2016).
MIMIC-III, a freely accessible critical care database.  Scientific Data, 3,
160035. <https://dx.doi.org/10.1038/sdata.2016.35>`__

**Please include the standard citation for PhysioNet:**

Goldberger, A., Amaral, L., Glass, L., Hausdorff, J., Ivanov, P.  C., Mark,
R., ... & Stanley, H. E. (2000). PhysioBank, PhysioToolkit, and PhysioNet:
Components of a new research resource for complex physiologic signals.
Circulation [Online]. 101 (23), pp. e215–e220.

+-----------+---------------------------------------------------------+
| APA       | Goldberger, A., Amaral, L., Glass, L., Hausdorff, J.,   |
|           | Ivanov, P. C., Mark, R., ... & Stanley, H. E. (2000).   |
|           | PhysioBank, PhysioToolkit, and PhysioNet: Components of |
|           | a new research resource for complex physiologic         |
|           | signals. Circulation [Online]. 101 (23), pp. e215–e220. |
+-----------+---------------------------------------------------------+
| MLA       | Goldberger, A., et al. "PhysioBank, PhysioToolkit, and  |
|           | PhysioNet: Components of a new research resource for    |
|           | complex physiologic signals. Circulation [Online]. 101  |
|           | (23), pp. e215–e220." (2000).                           |
+-----------+---------------------------------------------------------+
| CHICAGO   | Goldberger, A., L. Amaral, L. Glass, J. Hausdorff, P.   |
|           | C. Ivanov, R. Mark, J. E. Mietus, G. B. Moody, C. K.    |
|           | Peng, and H. E. Stanley. "PhysioBank, PhysioToolkit,    |
|           | and PhysioNet: Components of a new research resource    |
|           | for complex physiologic signals. Circulation [Online].  |
|           | 101 (23), pp. e215–e220." (2000).                       |
+-----------+---------------------------------------------------------+
| HARVARD   | Goldberger, A., Amaral, L., Glass, L., Hausdorff, J.,   |
|           | Ivanov, P.C., Mark, R., Mietus, J.E., Moody, G.B.,      |
|           | Peng, C.K. and Stanley, H.E., 2000. PhysioBank,         |
|           | PhysioToolkit, and PhysioNet: Components of a new       |
|           | research resource for complex physiologic signals.      |
|           | Circulation [Online]. 101 (23), pp. e215–e220.          |
+-----------+---------------------------------------------------------+
| VANCOUVER | Goldberger A, Amaral L, Glass L, Hausdorff J, Ivanov    |
|           | PC, Mark R, Mietus JE, Moody GB, Peng CK, Stanley HE.   |
|           | PhysioBank, PhysioToolkit, and PhysioNet: Components of |
|           | a new research resource for complex physiologic         |
|           | signals. Circulation [Online]. 101 (23), pp. e215–e220. |
+-----------+---------------------------------------------------------+

********
Abstract
********

The MIMIC-III Waveform Database contains 67,830 record sets for approximately
30,000 ICU patients. Almost all record sets include a waveform record
containing digitized signals (typically including ECG, ABP, respiration, and
PPG, and frequently other signals) and a “numerics” record containing time
series of periodic measurements, each presenting a quasi-continuous recording
of vital signs of a single patient throughout an ICU stay (typically a few
days, but many are several weeks in duration). A `subset of this database
</content/mimic3wdb-matched/>`__ contains waveform and numerics records that
have been matched and time-aligned with `MIMIC-III Clinical Database
</content/mimiciii/>`__ records.

**********
Background
**********

The MIMIC-III Waveform Database contains thousands of recordings of multiple
physiologic signals (“waveforms”) and time series of vital signs (“numerics”)
collected from bedside patient monitors in adult and neonatal intensive care
units (ICUs).

The MIMIC-III Waveform Database is a companion to the `MIMIC-III Clinical
Database </content/mimiciii/>`__, which contains detailed clinical information
about most of the patients represented in the Waveform Database [1]. Since the
contents of each database were collected independently, in partially
deidentified form, matching the clinical data with the waveform data is a
non-trivial task, and only a subset of Waveform Database records has been
matched with Clinical Database records. See the `MIMIC-III Waveform Database
Matched Subset </content/mimic3wdb-matched/>`__ for more information.

*******
Methods
*******

Unlike the original `MIMIC Database </content/mimicdb/>`__, waveforms were
collected in a largely automated fashion, from *all* of the bedside monitors in
certain adult and neonatal ICUs. Not all of the ICUs in the hospital were
included, and the data archiving process did not run continuously, but while it
was running, all waveforms from those ICUs were captured and archived. As a
result, these records represent a random sample of patients in those specific
ICUs.

Recorded waveforms and numerics vary depending on choices made by the ICU
staff. Waveforms almost always include one or more ECG signals, and often
include continuous arterial blood pressure (ABP) waveforms, fingertip
photoplethysmogram (PPG) signals, and respiration, with additional waveforms
(up to 8 simultaneously) as available. Numerics typically include heart and
respiration rates, SpO\ :sub:`2`, and systolic, mean, and diastolic blood
pressure, together with others as available. Recording lengths also vary; most
are a few days in duration, but some are shorter and others are several weeks
long.

The project was approved by the Institutional Review Boards of Beth Israel
Deaconess Medical Center (Boston, MA) and the Massachusetts Institute of
Technology (Cambridge, MA). Requirement for individual patient consent was
waived because the project did not impact clinical care and all protected
health information was deidentified.

****************
Data Description
****************

Each recording comprises two *records* (a waveform record and a matching
numerics record) in a single *record directory* (“folder”) with the name of the
record. To reduce access time, the record directories have been distributed
among ten intermediate-level directories (listed below). The names of these
intermediate directories (30, 31, ..., 39) match the first two digits of the
record directories they contain.

In almost all cases, the waveform records comprise multiple segments, each of
which can be read as a separate record. Each segment contains an uninterrupted
recording of a set of simultaneously observed signals, and the signal gains do
not change at any time during the segment. Whenever the ICU staff changed the
signals being monitored or adjusted the amplitude of a signal being monitored,
this event was recorded in the raw data dump, and a new segment begins at that
time.

Each composite waveform record includes a list of the segments that comprise it
in its *master header file*. The list begins on the second line of the master
header with a *layout header file* that specifies all of the signals that are
observed in any segment belonging to the record.  Each segment has its own
*header file* and (except for the layout header) a matching (binary) *signal
(.dat) file*. Occasionally, the monitor may be disconnected entirely for a
short time; these intervals are recorded as gaps in the master header file, but
there are no header or signal files corresponding to gaps.

The numerics records (designated by the letter ``n`` appended to the record
name) are not divided into segments, since the storage savings that would be
achieved by doing so would be relatively little.

Physiologic waveform records in this database contain up to eight
simultaneously recorded signals digitized at 125 Hz with 8-, 10-, or
(occasionally) 12-bit resolution. Numerics records typically contain 10 or more
time series of vital signs sampled once per second or once per minute.

*********************
Technical Limitations
*********************

**Waveforms or numerics missing:**

   Occasionally, technical limitations of the data acquisition system make it
   possible to create a physiologic waveform record but not a numerics record,
   or vice versa.

**A given signal may not be available throughout an entire record:**

   Records in the MIMIC-III Waveform Database vary in length; some are several
   weeks in duration. It is common for the physiologic signals to be
   interrupted or changed occasionally during recordings of such long duration.
   When using a viewer such as `LightWAVE </lightwave/>`__, all signals
   available at any time during a record are listed, although in most cases
   only a subset is visible at any given time.

**Gaps and patient identification:**

   The waveform and numerics records have been extracted from raw data dumps
   collected from the bedside monitors using a facility provided by the monitor
   manufacturer. The raw data dumps contain files of data collected from a
   single patient monitor during a single monitoring session (which may last
   days or weeks). Usually the monitoring session ends when the patient is
   discharged, so that the data in a single file come from a single patient.
   Occasionally, however, the monitor is not reset when the patient is
   discharged, and the session continues after a new patient has been admitted;
   in this case the raw data file contains data from two (or more) patients,
   with a gap (an interval during which no waveforms or numerics are recorded)
   that is typically an hour or more in duration. Such gaps may also appear if
   the monitor is temporarily disconnected (for example, for a laboratory test)
   and then reconnected to the same patient. Since the raw data files do not
   usually contain patient identifiers, it is not trivial to determine with
   certainty if the data before and after a gap were collected from the same
   patient.  Ideally, each MIMIC-III Waveform Database record should contain
   data from only one patient. All raw data files containing gaps of an hour or
   more have been split into separate records in order to decrease the
   likelihood that any record contains data from multiple patients.  An ongoing
   project is to examine the sets of records created this way, matching them
   with MIMIC-III Clinical Database records when possible, to determine if and
   how they should be reassembled.

**Inter-waveform alignment problems:**

   The method used for MIMIC waveform data extraction was not designed for
   inter-waveform analysis. The waveform data contain unspecified/unknown
   filtering delays and/or unknown inter-channel delays, which may not be
   constant in a given record. Therefore, although the ECGs are time-aligned
   with each other, there may be a (changing) delay of up to 500ms between any
   of the other waveforms in the data. For example, the pulse transit time
   measured between different waveforms may be unreliable (either in absolute
   or relative terms).

**ECG limitations:**

   The ECG signals in the waveform records were originally sampled with 12-bit
   precision at a high sampling rate, and were then scaled and decimated to 500
   samples per second (per signal). The scaling reduced the effective amplitude
   resolution from 12 bits to 9 or 10 bits in typical cases, and as little as 7
   bits in some cases. From each set of 4 consecutive decimated samples of the
   same ECG signal, one was recorded (chosen using a turning-point compressor,
   a technique sometimes called “peak-picking”). The result is an ECG signal
   sampled 125 times per second, but at intervals that vary between 2 and 14 ms
   (averaging 8 ms). Since the interval between any given pair of samples was
   not available to us, the reconstructions of the ECG signals assume uniform 8
   ms intervals. These signals with reduced time and amplitude resolution, and
   sampling jitter introduced by the “peak-picking”, were the only ECG signals
   that were possible to capture from the ICU monitors. Although ECGs
   reconstructed in this way can be readily interpreted visually, they are
   unsuitable as input for certain algorithms for ECG analysis, particularly
   those that are sensitive to frequency-domain features of the signal. Note
   that these limitations apply only to the ECG signals, not to the other
   signals, which were originally sampled at uniform 8 ms intervals (125
   samples per second) and were not scaled prior to capture.

***********
Usage Notes
***********

The following example illustrates the organization of the database:

-  Intermediate directory `31 <31/>`__ contains all records with names that
   begin with ``31``.
-  Record directory `3141595 <31/3141595/>`__ is contained within intermediate
   directory 31.
-  All files associated with physiologic waveform record 3141595 and its
   companion numerics record 3141595n are contained within record directory
   `31/3141595 <31/3141595/>`__.

   -  The first line of the master header file for waveform record 314595
      (`31/3141595/3141595.hea <31/3141595/3141595.hea>`__) indicates that the
      record is 242353557 sample intervals (about 22 days at 125 samples per
      second) in duration, and that it contains 427 segments and gaps. (See
      `header(5) </physiotools/wag/header-5.htm#sect5>`__ in the WFDB
      Applications Guide for details on the format of this text file.) The first
      segment is named 3141595_0001, and it is 2888500 sample intervals (6
      hours, 15 minutes, and 8 seconds, at 125 samples per second) in duration.
      At the end of the master header file, a comment (``# Location: nicu``)
      specifies the ICU in which the recording was made (the neonatal ICU, in
      this case).
   -  The layout header file for this record (`31/3141595/3141595_layout.hea
      <31/3141595/3141595_layout.hea>`__) indicates that five ECG signals (I,
      II, III, AVR, and “V”), a respiration signal, and a PPG signal are
      available during portions of the record. (The five ECG signals are not all
      available simultaneously.)
   -  The header file for the first segment of this record
      (`31/3141595/3141595_0001.hea <31/3141595/3141595_0001.hea>`__) shows that
      a PPG signal (“PLETH”), a respiration signal, and ECG leads II and AVR are
      available throughout this initial segment.

-  The matching numerics record is named 3141595n, and its header file
   (`31/3141595/3141595n.hea <31/3141595/3141595n.hea>`__) shows that it is
   1938730 sample intervals (about 22 days at 1 sample per second) in duration,
   and that it contains heart rate (“HR”, which is measured from the ECG, as
   well as “PULSE”, measured from one or more pulsatile signals), noninvasive
   blood pressure (raw as well as systolic, diastolic, and mean), respiration
   rate, and SpO\ :sub:`2`.

Any `WFDB application <https://archive.physionet.org/physiotools/wfdb.shtml>`__
can read any waveform record from this database directly from the PhysioNet web
server (i.e., without downloading the record first) using a record name of the
form ``mimic3wdb/3``\ *``x``*\ ``/3``\ *``xyyyyy``*\ ``/``. Numerics records
can be read using the longer form ``mimic3wdb/3``\ *``x``*\ ``/3``\
*``xyyyyy``*\ ``/3``\ *``xyyyyy``*\ ``n`` (note that the final ``3``\
*``xyyyyy``* must be repeated and followed by ``n`` to specify the numerics
record).

For example, if you have installed the `WFDB Software Package
<https://archive.physionet.org/physiotools/wfdb.shtml>`__, you can read the
first 10 seconds of waveform record 3141595 using this **rdsamp** command:

::

   rdsamp -r mimic3wdb/31/3141595/ -p -v -t 10

To read the first 10 seconds of the matching numerics record 3141595n, use this
command instead:

::

   rdsamp -r mimic3wdb/31/3141595/3141595n -p -v -t 10

Notice that the first command produces 1250 samples of each waveform (125
samples per second, for 10 seconds), but the second command produces only 10
samples of each vital sign (1 sample per second, for 10 seconds).

*************
Release Notes
*************

Version 1.0 of the MIMIC-III Waveform Database supersedes previously-released
versions of the MIMIC-II Waveform Database. The *numbered* records (3000003 to
3999988) are identical to those in version 3.2 of the MIMIC-II Waveform
Database. The `Matched Subset </content/mimic3wdb-matched/1.0/>`__, however,
uses different subject IDs and surrogate dates, corresponding to `version 1.4
of the MIMIC-III Clinical Database </content/mimiciii/1.4/>`__.

****************
Acknowledgements
****************

We wish to thank Philips Healthcare, as well as the Beth Israel Deaconess
Medical Center, for their invaluable support in making this project possible.

Many people have contributed to this project over the past 18 years, and it
would be impossible to list them all. In particular, we would like to
acknowledge Michael Craig, Tin Kyaw, and Mohammed Saeed, for their efforts in
collecting and organizing the original MIMIC-II Waveform Database, upon which
this database is based.

*********************
Conflicts of Interest
*********************

The authors have no conflicts of interests to declare.

**********
References
**********

#. Johnson, A. E. W., Pollard, T. J., Shen, L., Lehman, L. H., Feng, M.,
   Ghassemi, M., Moody, B., Szolovits, P., Celi, L. A., & Mark, R. G.  (2016).
   MIMIC-III, a freely accessible critical care database.  Scientific Data, 3,
   160035. https://dx.doi.org/10.1038/sdata.2016.35
