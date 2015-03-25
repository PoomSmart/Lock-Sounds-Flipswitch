SDKVERSION = 7.0
ARCHS = armv7 arm64

include theos/makefiles/common.mk

BUNDLE_NAME = LockSounds
LockSounds_FILES = Switch.xm
LockSounds_LIBRARIES = flipswitch substrate
LockSounds_FRAMEWORKS = UIKit
LockSounds_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk
