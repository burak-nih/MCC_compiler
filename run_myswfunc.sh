{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #!/bin/sh\
# script for execution of deployed applications\
#\
# Sets up the MATLAB Runtime environment for the current $ARCH and executes \
# the specified command.\
#\
exe_name=$0\
exe_dir=`dirname "$0"`\
echo "------------------------------------------"\
if [ "x$1" = "x" ]; then\
  echo Usage:\
  echo    $0 \\<deployedMCRroot\\> args\
else\
  echo Setting up environment variables\
  MCRROOT="$1"\
  echo ---\
  LD_LIBRARY_PATH=.:$\{MCRROOT\}/runtime/glnxa64 ;\
  LD_LIBRARY_PATH=$\{LD_LIBRARY_PATH\}:$\{MCRROOT\}/bin/glnxa64 ;\
  LD_LIBRARY_PATH=$\{LD_LIBRARY_PATH\}:$\{MCRROOT\}/sys/os/glnxa64;\
  LD_LIBRARY_PATH=$\{LD_LIBRARY_PATH\}:$\{MCRROOT\}/sys/opengl/lib/glnxa64;\
  export LD_LIBRARY_PATH;\
  echo LD_LIBRARY_PATH is $\{LD_LIBRARY_PATH\};\
# Preload glibc_shim in case of RHEL7 variants\
  test -e /usr/bin/ldd &&  ldd --version |  grep -q "(GNU libc) 2\\.17"  \\\
            && export LD_PRELOAD="$\{MCRROOT\}/bin/glnxa64/glibc-2.17_shim.so"\
  shift 1\
  args=\
  while [ $# -gt 0 ]; do\
      token=$1\
      args="$\{args\} \\"$\{token\}\\"" \
      shift\
  done\
  eval "\\"$\{exe_dir\}/myswfunc\\"" $args\
fi\
exit\
\
}