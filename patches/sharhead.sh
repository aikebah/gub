#!/bin/sh

me=$0
prefix=$HOME/
interactive=yes
if test `whoami` = "root"; then
  prefix=/usr/local/
fi


while test "$1" != ""; 
do
  case $1 in
  --help)
      cat <<EOF
$me - install LilyPond tarball
Options 
  --prefix PREFIX     install into PREFIX/lilypond/ (default: $prefix)
  --batch             no interaction
  --help              this help 
EOF
    exit 0
    ;;
  --prefix)
    if test "$prefix" = "" ; then
      shift
      prefix=$1/
    fi
    if test "$prefix" = "" ; then
      echo 'Option --prefix requires argument.'
      exit 1
    fi
    ;;
  --batch)
    interactive=no 
    ;;

  *)
    echo Unknown option: $1
    exit 2
    ;;
  esac
  shift 
done


cat<<EOF

LilyPond installer for %(hello)s.
Use --help for help

EOF

if interactive=yes; then
  cat <<EOF

You're about to install lilypond in ${prefix}lilypond/ 
A script in ${prefix}bin/ will be created as a shortcut. 

Press ^C to abort, or Enter to proceed 
EOF
  read junk
fi


lilydir=${prefix}lilypond/ 
wrapscript=${prefix}bin/lilypond

for d in $lilydir ${prefix}/bin ; do
  if test ! -d  $d; then
    echo Making $d 
    mkdir -p $d
  fi
done


echo Creating script $wrapscript

rm -f $wrapscript >& /dev/null
cat<<EOF > $wrapscript
#!/bin/sh
$prefix/lilypond/usr/bin/lilypond $@
EOF
chmod +x $wrapscript

echo Untarring $me
tail -c+%(header_length)012d $0 | tar -C $lilydir -xzf -

## need this because binary data starts after this.
exit 0
## END of script
