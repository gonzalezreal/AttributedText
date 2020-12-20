DESTINATION_MAC = platform=macOS
DESTINATION_IOS = generic/platform=ios
DESTINATION_TVOS = generic/platform=tvos
DESTINATION_WATCHOS = generic/platform=watchOS

default: build

build:
	xcodebuild \
			-scheme AttributedText \
			-destination '$(DESTINATION_MAC)'
	xcodebuild \
			-scheme AttributedText \
			-destination '$(DESTINATION_IOS)'
	xcodebuild \
			-scheme AttributedText \
			-destination '$(DESTINATION_TVOS)'
	xcodebuild \
			-scheme AttributedText_watchOS \
			-destination '$(DESTINATION_WATCHOS)'

format:
	swiftformat .

.PHONY: format
