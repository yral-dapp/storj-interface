# proper input
POST {{host}}/duplicate
Authorization: Bearer {{api_token}}
{
  "publisher_user_id": "{{publisher}}",
  "video_id": "{{video_id}}",
  "is_nsfw": false,
  "metadata": {
    "test": "value"
  }
}
HTTP 200

# Segregate nsfw videos
POST {{host}}/duplicate
Authorization: Bearer {{api_token}}
{
  "publisher_user_id": "{{publisher}}",
  "video_id": "{{video_id}}",
  "is_nsfw": true,
  "metadata": {
    "test": "value"
  }
}
HTTP 200

# Without auth token
POST {{host}}/duplicate
{
  "publisher_user_id": "{{publisher}}",
  "video_id": "{{video_id}}",
  "is_nsfw": false,
  "metadata": {
    "test": "value"
  }
}
HTTP 401

# With wrong token
POST {{host}}/duplicate
Authorization: Bearer wrongtoken
{
  "publisher_user_id": "{{publisher}}",
  "video_id": "{{video_id}}",
  "is_nsfw": false,
  "metadata": {
    "test": "value"
  }
}
HTTP 401

# when the video doesn't exist
POST {{host}}/duplicate
Authorization: Bearer {{api_token}}
{
  "publisher_user_id": "{{publisher}}",
  "video_id": "an_id_that_doesnt_exist_on_cloudflare",
  "is_nsfw": false,
  "metadata": {
    "test": "value"
  }
}
HTTP 404

# malformed input
POST {{host}}/duplicate
Authorization: Bearer {{api_token}}
`malformed json input`
HTTP 415

# missing required information
POST {{host}}/duplicate
Authorization: Bearer {{api_token}}
{
  "video_id": "{{video_id}}",
  "is_nsfw": false,
  "metadata": {
    "test": "value"
  }
}
HTTP 422
