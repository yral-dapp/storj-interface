# proper input
POST {{host}}/duplicate
Authorization: Bearer testtoken
{
  "publisher_user_id": "{{publisher}}",
  "video_id": "7ec40a0b9aba4307a97e8666822ed563",
  "is_nsfw": false,
  "metadata": {
    "test": "value"
  }
}
HTTP 200

# Segregate nsfw videos
POST {{host}}/duplicate
Authorization: Bearer testtoken
{
  "publisher_user_id": "{{publisher}}",
  "video_id": "7ec40a0b9aba4307a97e8666822ed563",
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
  "video_id": "7ec40a0b9aba4307a97e8666822ed563",
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
  "video_id": "7ec40a0b9aba4307a97e8666822ed563",
  "is_nsfw": false,
  "metadata": {
    "test": "value"
  }
}
HTTP 401

# when the video doesn't exist
POST {{host}}/duplicate
Authorization: Bearer testtoken
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
Authorization: Bearer testtoken
`malformed json input`
HTTP 415

# missing required information
POST {{host}}/duplicate
Authorization: Bearer testtoken
{
  "video_id": "7ec40a0b9aba4307a97e8666822ed563",
  "is_nsfw": false,
  "metadata": {
    "test": "value"
  }
}
HTTP 422
