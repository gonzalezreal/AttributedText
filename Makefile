DESTINATION_MAC = platform=macOS
DESTINATION_IOS = platform=iOS Simulator,name=iPhone 8
DESTINATION_TVOS = platform=tvOS Simulator,name=Apple TV

default: test

test:
	xcodebuild test \
			-scheme AttributedText \
			-destination '$(DESTINATION_MAC)'
	xcodebuild test \
			-scheme AttributedText \
			-destination '$(DESTINATION_IOS)'
	xcodebuild test \
			-scheme AttributedText \
			-destination '$(DESTINATION_TVOS)'

format:
	swiftformat .

.PHONY: format
