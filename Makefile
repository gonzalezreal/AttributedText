DESTINATION_MAC = platform=macOS
DESTINATION_IOS = platform=iOS Simulator,name=iPhone 8
DESTINATION_TVOS = platform=tvOS Simulator,name=Apple TV
DESTINATION_WATCHOS = generic/platform=watchOS

default: test

test:
	xcodebuild \
			-scheme AttributedText \
			-destination '$(DESTINATION_MAC)'
	xcodebuild test \
			-scheme AttributedText \
			-destination '$(DESTINATION_IOS)'
	xcodebuild test \
			-scheme AttributedText \
			-destination '$(DESTINATION_TVOS)'
	xcodebuild \
			-scheme AttributedText_watchOS \
			-destination '$(DESTINATION_WATCHOS)'

format:
	swiftformat .

.PHONY: format
