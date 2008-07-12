ENV['TM_BUNDLE_SUPPORT'] = "#{Dir.pwd}/../Support"
ENV['TM_SUPPORT_PATH'] = "/Library/Application Support/TextMate/Support"
require File.dirname(__FILE__) + "/../Support/cpp_completion.rb"
require 'pp'

describe "CppMethodCompletion#lookupT" do
  before :each do
    @completion = CppMethodCompletion.new ""
  end
  
  it "returns a dict describing the return type, if input is a known variable with that type" do
    item = {:kind=>:field, :name=>"map", :dref=>0}
    scope = ["#localScope"]
    qualifier = []
    expected = {:type=>"std::map",
          :pointers=>0,
          :t=>
           {1=>
             {:type=>"a",
              :scope=>[ "#localScope"],
              :pointers=>0},
            2=>
             {:type=>"b",
              :scope=>["#localScope"],
              :pointers=>0}}}
    @completion.res_hier =  {:namespace => { 
      "#localScope"=> {:field=> {"map"=>
        expected.dup}}}}
    
    result = @completion.lookupT(item, scope, qualifier)
    result.should == expected
  end
  
  it "returns a dict describing the return type, if input is a known method, in a known scope" do
    item = {:kind=>:methods, :name=>"begin", :dref=>0}
    scope = ["std", "map"]
    qualifier = []
    @completion.res_hier = {}
    result = @completion.lookupT(item, scope, qualifier)
    result.should == {:type=>"map::iterator", :a=>"()"}
  end
  
  it "returns a dict describing the return type, if input is a known method, in a known scope, even if the scope points to a typedef" do
    item = {:kind=>:methods, :name=>"begin", :dref=>0}
    scope = ["#localScope"]
    qualifier = ["map"]
    expected = {:type=>"std::map",
     :pointers=>0,
     :t=>
      {1=>
        {:type=>"a",
         :pointers=>0,
         :scope=>["#localScope"]},
       2=>
        {:type=>"b",
         :pointers=>0,
         :scope=>["#localScope"]}}}
         
    @completion.res_hier ={:namespace => { 
           "#localScope"=> {:typedefs=> {"map"=> expected.dup },
           :field=>{"mapx"=>{:type=>"map", :pointers=>0}}}}}
    result = @completion.lookupT(item, scope, qualifier)
    result.should == {:type=>"map::iterator", :a=>"()"}
  end

end