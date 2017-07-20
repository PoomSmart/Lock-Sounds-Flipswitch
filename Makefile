PACKAGE_VERSION = 0.0.3
TARGET = iphone:clang:latest:5.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = LockSounds
LockSounds_FILES = Switch.xm
LockSounds_LIBRARIES = flipswitch substrate
LockSounds_FRAMEWORKS = UIKit
LockSounds_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk
