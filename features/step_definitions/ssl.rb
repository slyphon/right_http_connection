#--  -*- mode: ruby; encoding: utf-8 -*-
# Copyright: Copyright (c) 2011 RightScale, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# 'Software'), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

Given /^an HTTPS URL$/ do
  Given "a really dumb SSL enabled web server"
  @uri = URI.parse("https://127.0.0.1:7890/good")
  @expected_contents = "good"
end

Given /^a CA certification file containing that server$/ do
  @ca_file = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec", "good.ca"))
end

Given /^a CA certification file not containing that server$/ do
  @ca_file = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec", "bad.ca"))
end

Given /^the strict failure option turned on$/ do
  @fail_if_ca_mismatch = true
end

Then /^there should be a warning about certificate verification failing$/ do
  @output.string.should =~ /.*WARN -- : ##### 127\.0\.0\.1 certificate verify failed:.*/
end

Then /^there should not be a warning about certificate verification failing$/ do
  @output.string.should_not =~ /.*WARN -- : ##### 127\.0\.0\.1 certificate verify failed:.*/
end
