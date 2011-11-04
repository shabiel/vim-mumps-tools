#!/bin/bash
#
# $Source: /home/vpe/RCS/m-ctags.sh,v $
# $Revision: 20100111.3 $
#
# Written by David Wicksell <dlw@linux.com>
# Copyright © 2010 Fourth Watch Software
# Licensed under the terms of the GNU Affero General
# Public License. See attached copy of the License.
#
# This program creates a file called tags,
# which it will place in the directory in
# which you called it. When you use vim, it
# will allow you to jump between the caller
# and the called portions of mumps code,
# regardless of which routine you are in.

function m-ctags {
  for ROUTINE
    do
      TMP=`basename ${ROUTINE} .m`
      if [ "${TMP}" == "*" ]; then
        break
      fi
      if [ "${ROUTINE: -2}" == ".m" ]; then
        FILE=`basename ${ROUTINE} .m | tr _ %`
        ctags ${ARG} -a --langdef=MUMPS --langmap=MUMPS:.m \
        --regex-MUMPS="/^([%[:alnum:]]+)/\1\^${FILE}/F,filename/i" ${ROUTINE}
      fi
    done
}

function m-ctags_default {
  for DIR in ${gtmroutines}
    do
      DIR=`echo ${DIR} | cut -d "(" -f 2 | cut -d ")" -f 1`
      m-ctags ${DIR}/*.m
    done
}

if [ $# -lt 1 ]; then
  echo -n "Usage: `basename $0` [-g|-d <directories>+]"
  echo "[<mumps-program-that-ctags-indexes>]+"
  exit 1
fi

if [ -f ~/.tags.tmp -o -f ~/tags.tmp ]; then
  echo "Script `basename $0` already running"
  exit 2
fi

case $1 in
  -w)
    ARG="-f .tags.tmp"
    m-ctags_default
    ;;
  -g)
    ARG="-f .tags"
    m-ctags_default
    ;;
  -d)
    ARG="-f tags.tmp"
    shift
    if [ $# -lt 1 ]; then
      echo "Error: You must supply directory names to the -d option"
      exit 3
    fi
    for DIR in $@
      do
        m-ctags ${DIR}/*.m
      done
    ;;
  -*)
    echo "Error: $1 is not a valid option"
    exit 4
    ;;
  *)
    ARG=""
    m-ctags $@
    ;;
esac

exit 0

# $RCSfile: m-ctags.sh,v $
