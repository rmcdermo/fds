#!/bin/bash

# This script runs a set of Validation Cases on a Linux machine with a batch queuing system.
# See the file Validation/Common_Run_All.sh for more information.
export INDIR=`pwd`/AIT_ZONE_2
export QFDS=$FIREMODELS/fds/Utilities/Scripts/qfds.sh
export EMAIL=randall.mcdermott@nist.gov
export QUEUE=batch

$QFDS -b $EMAIL -p 14 -q $QUEUE -d $INDIR methane_dx_2p5cm.fds
$QFDS -b $EMAIL -p 14 -q $QUEUE -d $INDIR propane_dx_2p5cm.fds
$QFDS -b $EMAIL -p 14 -q $QUEUE -d $INDIR methane_XO2_p18_dx_2p5cm.fds

$QFDS -b $EMAIL -p 24 -q $QUEUE -d $INDIR methane_dx_1p25cm.fds
$QFDS -b $EMAIL -p 24 -q $QUEUE -d $INDIR propane_dx_1p25cm.fds
$QFDS -b $EMAIL -p 24 -q $QUEUE -d $INDIR methane_XO2_p18_dx_1p25cm.fds

$QFDS -b $EMAIL -p 164 -q $QUEUE -d $INDIR methane_dx_p625cm.fds
$QFDS -b $EMAIL -p 164 -q $QUEUE -d $INDIR propane_dx_p625cm.fds
$QFDS -b $EMAIL -p 164 -q $QUEUE -d $INDIR methane_XO2_p18_dx_p625cm.fds

$QFDS -b $EMAIL -p 204 -q $QUEUE -d $INDIR methane_dx_p3125cm.fds
$QFDS -b $EMAIL -p 204 -q $QUEUE -d $INDIR propane_dx_p3125cm.fds
$QFDS -b $EMAIL -p 204 -q $QUEUE -d $INDIR methane_XO2_p18_dx_p3125cm.fds

echo FDS cases submitted
