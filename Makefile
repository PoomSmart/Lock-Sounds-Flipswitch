TARGET = iphone:latest:7.0
DEBUG = 0
PACKAGE_VERSION = 0.0.2

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = LockSounds
LockSounds_FILES = Switch.xm
LockSounds_LIBRARIES = flipswitch substrate
LockSounds_FRAMEWORKS = UIKit
LockSounds_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk
