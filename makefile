################################################
# 交叉编译工具的存放位置
TOOLCHAIN = /home/mjj/QuecOpen_CrossCompiler/ql-oe/sysroots/x86_64-linux/usr/bin/arm-oe-linux-gnueabi
# 交叉编译前缀
CROSS_PREFIX = arm-oe-linux-gnueabi-
################################################
# 编译器所在位置
CC_PATH = $(TOOLCHAIN)
# 交叉编译器自带的头文件的根目录
SYSROOT_PATH = /home/mjj/QuecOpen_CrossCompiler/ql-oe/sysroots/mdm9607
# 编译器
CC = $(CC_PATH)/$(CROSS_PREFIX)gcc
# 目标文件
TARGET = vehicle
# 输出文件位置
OUTPUT_DIR = output
SO_TARGET = $(OUTPUT_DIR)/$(TARGET)

########## 编译选项 ##########
CFLAGS = -g -Wall -fPIC -fvisibility=hidden -Iinclude -I$(SYSROOT_PATH)/usr/include
LDFLAGS = -L$(SYSROOT_PATH)/usr/lib -lssl -lcrypto -lpthread

SRCS = vehicle.c
OBJS = $(SRCS:.c=.o)

# 默认目标
.PHONY: all clean

all: $(SO_TARGET)

$(SO_TARGET): $(SRCS)
	mkdir -p $(OUTPUT_DIR)
	export PATH=$$PATH:$(CC_PATH)
	$(CC) -std=gnu99 -o $(SO_TARGET) $(SRCS) $(CFLAGS) $(LDFLAGS) --sysroot=$(SYSROOT_PATH)
	@file $(SO_TARGET)

clean:
	rm -rf $(OUTPUT_DIR) *.o
