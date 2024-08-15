class HelloEmailJob
  include Sidekiq::Job

  def perform()
    puts "through welcome and hello email job"

  end
end
