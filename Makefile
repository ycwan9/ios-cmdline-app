GCC_BIN=`xcrun --sdk iphoneos --find gcc`
SDK=`xcrun --sdk iphoneos --show-sdk-path`
#support iPhone 3GS and above, delete armv6 to avoid SDK error
ARCH_FLAGS=-arch armv7 -arch armv7s -arch arm64

LDFLAGS	=\
	-F$(SDK)/System/Library/Frameworks/\
	-F$(SDK)/System/Library/PrivateFrameworks/\
	-framework UIKit\
	-framework CoreFoundation\
	-framework Foundation\
	-framework CoreGraphics\
	-framework Security\
	-lobjc\
	-lsqlite3\
	-bind_at_load

GCC_ARM = $(GCC_BIN) -Os -Wall -Wextra -Wimplicit -isysroot $(SDK) $(ARCH_FLAGS) -I ./theos_headers

default: program

program: unlock-test.o
	@$(GCC_ARM) $(LDFLAGS) unlock-test.o -o program

unlock-test.o: theos_headers unlock-test.m
	$(GCC_ARM) -c unlock-test.m

hello.o: hello.m
	$(GCC_ARM) -c hello.m

theos_headers:
	git clone --depth 1 https://github.com/theos/headers.git theos_headers

clean:
	rm -f *.o program
