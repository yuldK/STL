set(target test)
include_directories(${ROOT})
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

make_executable(${target} "CONSOLE")

# add_pch(${target} pch.cpp pch.h)

add_sources(${target}
	"span"
	"span.test.cpp"
	"${ROOT}/code/STL/span.hpp"
)

add_sources(${target}
	"test main"
)

#add_and_link_dependency(${target} )

target_link_libraries(${target}
	PUBLIC
		GTest::gtest
		GTest::gtest_main
		${WINLIBS}
)

enable_testing()
add_test(
	NAME ${target}
	COMMAND ${target}
)
