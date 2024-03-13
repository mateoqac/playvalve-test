## Getting Started

### Prerequisites

Make sure you have the following installed:

- Ruby (version 3.3.0)
- Ruby on Rails (< version 7.1)
- PostgreSQL@15
- Redis

### Installation

1. Clone the repository:
   ```bash
   git clone git@github.com:mateoqac/playvalve-test.git
2. Move to the project directory:
   ```bash
   cd playvalve-test
3. Install dependencies:
   ```bash
   bundle install
4. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
5. Load some countries into redis:
   ```ruby
   rake whitelist:countries
6. Create your `.env.*` file from `.env.template` and paste your `VPN_API_KEY`
   ```bash
   cp .env.template > .env.development
7. Running the server
   ```bash
   rails server
## API Endpoints

### User check_status

- **Endpoint:** `/api/v1/user/check_status`
- **Method:** `POST`
- **Description:** Will return the current ban_status of the give user.
- **Params:**
  * `idfa` (required)
  * `rooted_device` (required)

## Testing

The project includes RSpec tests for the API endpoints. Run the tests with:

```bash
bundle exec rspec
