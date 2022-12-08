describe "Driver", type: :model do
  it "can finish a ride" do
    driver = create(:driver, status: "RIDE")
    ride = create(:ride, driver: driver)
    body = driver.finish_ride(ride.id)
    expect(driver.status).to eq("AVAILABLE")
    expect(body).to be_a(Hash)
    expect(body[:amount_in_cents]).to be_a(Integer)
  end
end
