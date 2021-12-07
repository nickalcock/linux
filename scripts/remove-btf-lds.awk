# SPDX-License-Identifier: GPL-2.0
# See Makefile.vmlinux_o

BEGIN {
    discards = 0; p = 0
}

/^====/ { p = 1; next; }
p && /\.BTF/ { next; }
p && /\.ctf/ { next; }
wp && !discards && /DISCARD/ { sub(/\} *$/, " *(.BTF .ctf) }"); discards = 1 }
p && /^\}/ && !discards { print "  /DISCARD/ : { *(.BTF .ctf) }"; }
p { print $0; }
