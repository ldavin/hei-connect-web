require File.join(Rails.root, 'lib', 'openshift_secret_generator.rb')

HeiConnectWeb::Application.config.secret_token = initialize_secret(
    :token,
    'irKjbnpf6ALDpkcEvaa6mnyeTuGBYzXiBHRjJUbmjBqBBj9HTek8LzDtNDeCUxzE7dRBsfbPEWLcPbnkcZTKNpsz4rDgXiJNGvUa'
)
