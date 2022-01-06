# frozen_string_literal: true

require 'middleware/ogp'

Rails.application.config.middleware.use(Ogp)
