# Automateer

Automateer is a lightweight service designed to execute Puppeteer scripts efficiently. It provides a simple API to run browser automation tasks, making it ideal for web scraping, testing, and other automation needs.

## Features

### Current Features (v1.0.0)
- **Run Puppeteer Scripts**: Execute browser automation tasks via a REST API.
- **Express.js Backend**: Built on a lightweight and fast Express.js server.
- **Dockerized Deployment**: Easily deployable using Docker for consistent environments.

### Planned Features (Future Versions)
- **Queue System**: Handle multiple concurrent requests efficiently with a robust queue system.
- **Request Analytics**: Track and analyze each request, including execution time, CPU, and memory usage.
- **Enhanced Error Handling**: Improved error reporting and debugging capabilities.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/prantiknoor/automateer.git
   cd automateer
   ```

2. Build the Docker image:
   ```bash
   docker build -t automateer .
   ```

3. Run the Docker container:
   ```bash
   docker run -p 3000:3000 automateer
   ```

## Usage

1. Start the service (as shown above).
2. Send a POST request to `/run` with the following JSON payload:
   ```json
   [
    {
      "id": 1,
      "name": "open example.com",
      "method": "goto",
      "params": {
        "url": "https://example.com",
        "options": {
          "waitUntil": "networkidle2"
          }
        }
      },
      {
        "id": 2,
        "name": "get title of the page",
        "method": "title",
        "include": true
      },
      {
        "id": 3,
        "name": "get paragraph",
        "method": "$eval",
        "params": {
          "selector": "p",
          "pageFunction": "(el)=>{const paragraph = el.innerText;return paragraph.toLowerCase();}"
        },
        "include": true
      }
    ]
   ```
   *?`include: true` means, It will include output of the task in the response.*
3. The service will return the outputs of the tasks. Output:
   ```json
   {
     "2": "Example Domain",
     "3": "this domain is for use in illustrative examples in documents. you may use this domain in literature without prior coordination or asking for permission."
   }
    ```

## Project Structure

- `api.mjs`: Express.js server handling API requests.
- `script.mjs`: Core logic for executing Puppeteer tasks.
- `Dockerfile`: Configuration for building the Docker image.

## Dependencies

- **Express.js**: Backend framework.
- **Morgan**: HTTP request logger.
- **Puppeteer**: Headless browser automation library.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests for new features, bug fixes, or documentation improvements.

## Roadmap

- [ ] Implement a queue system for concurrent requests.
- [ ] Add analytics for request performance.
- [ ] Improve error handling and logging.

## Contact

For questions or support, please contact [Prantik](mailto:prantiknoor@gmail.com).