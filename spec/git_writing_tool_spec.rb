describe "#get_calling_file" do
  it "returns the file calling the function" do
    expect( Runner.new.get_calling_file ).to eq("git_writing_tool_spec.rb")
  end
end

