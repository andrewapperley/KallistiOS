#
# Objective-C Foundation Example
# (c) 2023 Andrew Apperley
#   

TARGET = foundation.elf
OBJS = ./NSObject/NSObjectTests.o ./Containers/ContainerTests.o ./foundation.o 
CFLAGS = -std=c11

all: rm-elf $(TARGET)

include $(KOS_BASE)/Makefile.rules

clean: rm-elf
	-rm -f $(OBJS) 

rm-elf:
	-rm -f $(TARGET) $(OBJS)

$(TARGET): $(OBJS)
	kos-c++ -o $(TARGET) $(OBJS)

run: $(TARGET)
	$(KOS_LOADER) $(TARGET)

dist: $(TARGET)
	-rm -f $(OBJS)
	$(KOS_STRIP) $(TARGET)

