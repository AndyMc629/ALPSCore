#
# This cmake script adds test to a project from the 'test' directory in the ALPS module
#

# check xml output
option(TestXMLOutput "Output tests to xml" OFF)

# enable testing with gtest
if (NOT tests_are_already_enabled) 
    message(STATUS "Building tests")
    include(UseGtest) # consider using cmake FindGTest
    set (LINK_TEST gtest_main)
    add_subdirectory(${gtest_ROOT} ${PROJECT_BINARY_DIR}/gtest)
    include_directories(${gtest_INCLUDE_DIR})
    set(tests_are_already_enabled TRUE)
endif(NOT tests_are_already_enabled)

# custom function to add test with xml output and linked to gtest
# arg0 - test (assume the source is ${test}.cpp
function(alps_add_gtest test)
    if (TestXMLOutput)
        set (test_xml_output --gtest_output=xml:${test}.xml)
    endif(TestXMLOutput)
    add_executable(${test} ${test}.cpp)
    target_link_libraries(${test} ${LINK_ALL} ${PROJECT_NAME} ${LINK_TEST})
    add_test(NAME ${test} COMMAND ${test} ${test_xml_output})
endfunction(alps_add_gtest)
