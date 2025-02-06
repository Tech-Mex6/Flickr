# Flickr Search App

This iOS app allows users to search for public images on Flickr, view details about each image, and share the images with their metadata. Built using SwiftUI and leveraging modern iOS features such as async/await for API calls and dynamic text support for accessibility.

## Features

- **Image Search**: Search for images on Flickr by keyword.
- **Image Grid**: Display search results in a responsive grid.
- **Image Detail View**: View detailed information about an image including:
  - Title
  - Description
  - Author
  - Published date (formatted)
  - Image dimensions (if available)
- **Share Functionality**: Share the image and its metadata through the system share sheet.
- **Accessibility Support**:
  - VoiceOver support for navigation and text.
  - Dynamic text support for different accessibility settings.
- **Responsive Design**: The app supports both portrait and landscape orientations.
- **Progress Indicator**: Displays a loading indicator during searches, without blocking the UI.

## Requirements

- iOS 16.0+
- Xcode 14.0+ (with Swift 5.7+)
- SwiftUI

## Installation

To run this app locally:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/flickr-search-app.git
