# Mailer API

Provides a single POST HTTP Endpoint for triggering emails based upon the properties supplied. This API integrates into our associated Lambda function for handling the processing of vast amounts of emails via a Kinesis stream.

**Note:** This API is (and should never be) exposed via a proxied public endpoint.

---

### `POST:/`

| Parameter | Required? | Type | Description |
|:----------|:----------|:----|:------------|
|`template`| yes | String | The full template key |
|`recipient`| yes | String | Email address of the intended recipient of the email |
|`data`| yes | Hash | Additional keys and values to be interpolated into the template |

There is no response body from this API. Success is indicated by a status code of `201`, or an error code will be returned.

## Getting Started

0. Ensure docker and docker-compose are installed.
0. Run `./script/build`

## Running Tests

0. Run `./script/run rspec`
