class Api::V1::UsersController < ApplicationController
    load_and_authorize_resource
    def index
        puts "hello world"
    end
end
