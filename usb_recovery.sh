#
# Copyright (c) 2016 Nexell Co., Ltd.
# Copyright (c) 2017 Samsung Electronics.
# Author: Sungwoo, Park <swpark@nexell.co.kr>
# Author: Jaewon Kim <jaewon02.kim@samsung.co.kr>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

#!/bin/bash

BOARD_NAME=${1}
NSIH=
BL1=
BL2=
DOWN_ADDR=
JUMP_ADDR=

if [ "${BOARD_NAME}" == "" ]; then
	echo "You must specify board name!"
	echo " - Usage: $0 <board-type>"
	exit 1
fi

if [ "${BOARD_NAME}" == "artik710" ]; then
	NSIH=raptor-32.txt
	BL1=bl1-usbboot.img
	BL2=fip-loader-usb.img
	DOWN_ADDR=0x7fc00000;
	JUMP_ADDR=0x7fe00000;
else
	echo "Unsupported Board Type !"
	echo "Board Type : artik710, artik530"
	exit 1
fi

./usb-downloader -t slsiap -n ${NSIH} -b ${BL1}
sleep 1
./usb-downloader -t slsiap -m -f ${BL2} -a ${DOWN_ADDR} -j ${JUMP_ADDR}