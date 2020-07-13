/*
 * KVM on Userspace
 *
 * (C) 2020.06.23 BuddyZhang1 <buddy.zhang@aliyun.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
/* KVM */
#include <linux/kvm.h>

static int kvm(uint8_t code[], size_t code_len)
{
	int kvmfd, vmfd;

	/* Open KVM */
	kvmfd = open("/dev/kvm_BiscuitOS", O_RDWR | O_CLOEXEC);
	if (kvmfd < 0) {
		printf("Open /dev/kvm_BiscuitOS failed: %d\n", errno);
		return -1;
	}

	/* Create KVM */
	vmfd = ioctl(kvmfd, KVM_CREATE_VCPU, 0);
	if (vmfd < 0) {
		printf("IOCTL: KVM_CREATE_VM failed: %d\n", errno);
		goto out;
	}

	close(kvmfd);
	return 0;

out:
	close(kvmfd);
	return -1;
}

int main(void)
{
	uint8_t code[] = "\x80\x61\xBA\x17\x02\xEE\xB0\n\xEE\xF4";

	kvm(code, sizeof(code));

	return 0;
}
