KBAWDUMP ;DLW**Dump a global on the command line ; 3/25/10 2:05pm
 ;;0.1;MASH;;David Wicksell @2010
 ;
 ; $Source: /home/vpe/dev/RCS/KBAWDUMP.m,v $
 ; $Revision: 20100322.1 $
 ;
 ; Copyright © 2010 Fourth Watch Software
 ; DL Wicksell <dlw@linux.com>
 ; Licensed under the terms of the GNU Affero General
 ; Public License. See attached copy of the License.
 ;
 ; This routine will dump the contents of a MUMPS global
 ; from a shell prompt. It is invoked as a mumps -run
 ; command. ie. mumps -r KBAWDUMP "^DD(0,0)"
 ;
 ; The quotes around the global name are required. If you
 ; don't put them, then most shells(BASH for sure) will 
 ; think you are trying to start a subshell with the "()"
 ; The "^" is optional, and putting a "-" as the first 
 ; character, will dump only the node referenced, otherwise
 ; it will be assumed that you want that node and every one
 ; of it's children.
 ;
 N $ET S $ET="G ERR"
 N ZCMD,GLOBAL,VIM S ZCMD=$ZCMD,VIM=0
 I $E(ZCMD)="-" S ZCMD=$E(ZCMD,2,$L(ZCMD)),VIM=1 ;Set VIM mode (no children)
 I $E(ZCMD)'="^" S ZCMD="^"_ZCMD
 ;
 I ZCMD["(" D  ;If you have subscripts, you need to isolate the contents
 . S GLOBAL=$P(ZCMD,"(")_"("
 . N ARG S ARG=$P(ZCMD,"(",2),ARG=$E(ARG,1,$L(ARG)-1)
 . I ARG["," D  ;If you have multiple subscripts, you need to break them apart
 . . ;Build a loop to deal with each subscript separately
 . . N NUM S NUM=$L(ARG,",") N I F I=1:1:NUM D
 . . . S ARG(I)=$P(ARG,",",I)
 . . . I 'VIM,$E(ARG(I))'?1(1N,1"""") S ARG(I)=""""_ARG(I)_"""" ;Add quotes
 . . . S GLOBAL=GLOBAL_ARG(I)_"," ;Rebuild the args
 . . S GLOBAL=$E(GLOBAL,1,$L(GLOBAL)-1) ;Get rid of last comma
 . . I VIM S GLOBAL=GLOBAL_")" ;Add the last ) back without the ,* in VIM mode
 . . E  S GLOBAL=GLOBAL_",*)" ;Add the last ) back with the ,* from the shell
 . ;See above for comments to below, which deal with only one subscript
 . E  D
 . . I 'VIM,$E(ARG)'?1(1N,1"""") S ARG=""""_ARG_""""
 . . S GLOBAL=GLOBAL_ARG
 . . I VIM S GLOBAL=GLOBAL_")"
 . . E  S GLOBAL=GLOBAL_",*)"
 E  S GLOBAL=ZCMD ;No subscripts
 ZWR @GLOBAL
 Q
 ;
ERR ; Handle globals that don't exist
 W !,$P($ZS," ",2,9),! 
 Q
 ;
 ; $RCSfile: KBAWDUMP.m,v $
