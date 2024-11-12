# RecipeFetch Project

## Steps to Run the App
1. Clone the repository from the provided URL.
2. Open the `.xcodeproj` or `.xcworkspace` file in Xcode.
3. Ensure that dependencies are installed using Swift Package Manager (SPM).
4. Select the appropriate scheme and device/simulator.
5. Build and run the project using `Cmd + R`.

## Focus Areas
I prioritized:
1. **Architecture Setup and Base Layers**: Setting up a clean and maintainable architecture (MVVM pattern) to separate concerns and improve code scalability and testability.
2. **Networking Layer**: Ensuring robust data fetching with error handling to demonstrate efficient API calls.
3. **UI Implementation**: Providing a user-friendly and responsive interface with features like data display and pull-to-refresh functionality.

These areas were chosen for their importance in ensuring the project was well-structured, efficient, and offered a good user experience from the start.

## Time Spent
- **Total Time Spent**: Approximately 3 hours
  - **Architecture Setup & Base Layers**: 1 hour
  - **Networking & UI Development**: 1 hour
  - **Unit Tests**: 30 minutes
  - **Remaining Time**: Spent on quick refactoring, documentation, and minor debugging.

## Trade-offs and Decisions
- **Unit Test Coverage**: Limited the scope of unit tests due to time constraints.
- **Concurrency**: Opted for Swift's async/await for simpler asynchronous code rather than Combine to prioritize readability and efficiency within a short timeframe.

## Weakest Part of the Project
- **Comprehensive Unit Tests**: The project lacks complete unit test coverage, as the focus was primarily on core functionalities and demonstrating the architecture in the available time.
- **UI Additional Cases**: Detailed UI may not have been fully handled due to time constraints.

## External Code and Dependencies
- **Swift Package Manager (SPM)**: Used for dependency management.
- **Kingfisher**: Utilized for efficient image downloading and caching.

## Additional Information
- The project was designed with extensibility and modularity in mind, making it easier to add new features or services.
- Constraints on time meant focusing on core features and demonstrating a clean architecture rather than extensive testing or handling all possible edge cases.
