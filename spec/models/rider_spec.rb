describe "Rider", type: :model do
  it "can request a ride" do
    rider = create(:rider)
    driver = create(:driver)
    ride = rider.request_ride(rider.location, driver)
    expect(ride).to eq(Ride.last.to_json)
  end

  it "cannot request a ride if there are no available drivers" do
    rider = create(:rider)
    driver = create(:driver, status: "RIDE")
    ride = rider.request_ride(rider.location, driver)
    expect(ride).to eq({message: 'No available drivers'}.to_json)
  end
end
