#!/bin/bash
#
# $Source: /home/vpe/RCS/run_m-ctags.sh,v $
# $Revision: 20100111.3 $
#
# Written by David Wicksell <dlw@linux.com>
# Copyright © 2010 Fourth Watch Software
# Licensed under the terms of the GNU Affero General
# Public License. See attached copy of the License.
#
# A script which will call m-ctags.sh from cron
# It will create a tags file called .tags in ~

cd ~
source bin/set_env

LOG=~/log/`basename $0 .sh`.log

date                                                            >${LOG} 2>&1

bin/m-ctags.sh -w                                              >>${LOG} 2>&1
if [ -s ~/.tags.tmp ]; then
    mv ~/.tags.tmp ~/.tags                                     >>${LOG} 2>&1
fi

# Uncomment below to add directories with routines in unusual
# places, that won't get picked up via $gtmroutines
# It will create a file called tags, instead of .tags
# You can think of these lines as local modifications

#bin/m-ctags.sh -d lib/ewd/routines lib/mgwsi lib/serenji
#if [ -s ~/tags.tmp ]; then
#    mv ~/tags.tmp ~/tags                                       >>${LOG} 2>&1
#fi

date                                                           >>${LOG} 2>&1

exit 0

# $RCSfile: run_m-ctags.sh,v $
