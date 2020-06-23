#
# BiscuitOS KVM
#
# (C) 2020.02.02 BuddyZhang1 <buddy.zhang@aliyun.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.

## Target
ifeq ("$(origin MODULE_NAME)", "command line")
TARGET			:= $(MODULE_NAME)
else
TARGET			:= KVM_user_BiscuitOS
endif

## Source Code
SRC			+= main.c

## CFlags
LCFLAGS			+= -DCONFIG_BISCUITOS_APP
## Header
LCFLAGS			+= -I./

DOT			:= -
## X86/X64 Architecture
ifeq ($(ARCH), i386)
CROSS_COMPILE	:=
LCFLAGS		+= -m32
DOT		:=
else ifeq ($(ARCH), x86_64)
CROSS_COMPILE	:=
DOT		:=
endif

# Compile
B_AS		= $(CROSS_COMPILE)$(DOT)as
B_LD		= $(CROSS_COMPILE)$(DOT)ld
B_CC		= $(CROSS_COMPILE)$(DOT)gcc
B_CPP		= $(CC) -E
B_AR		= $(CROSS_COMPILE)$(DOT)ar
B_NM		= $(CROSS_COMPILE)$(DOT)nm
B_STRIP		= $(CROSS_COMPILE)$(DOT)strip
B_OBJCOPY	= $(CROSS_COMPILE)$(DOT)objcopy
B_OBJDUMP	= $(CROSS_COMPILE)$(DOT)objdump

## Install PATH
INSTALL_PATH		:= $(BSROOT)/rootfs/rootfs/usr/bin

all:
	$(B_CC) $(LCFLAGS) -o $(TARGET) $(SRC)

install:
	@cp -rfa $(PWD)/$(TARGET) $(INSTALL_PATH)
	@chmod 755 $(PWD)/RunBiscuitOS_UKVM.sh
	@cp -rfa $(PWD)/RunBiscuitOS_UKVM.sh $(INSTALL_PATH)

clean:
	@rm -rf BiscuitOS_UKVM-* *.o
