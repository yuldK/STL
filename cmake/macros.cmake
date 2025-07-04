# macros.cmake

macro(set_install_prefix root)
	set(CMAKE_INSTALL_PREFIX "${root}/bin/$<CONFIG>")
endmacro()

function (subsystem module sub)
	set_target_properties (${module} PROPERTIES LINK_FLAGS "/SUBSYSTEM:${sub}")
	if (${sub} STREQUAL "WINDOWS")
		add_definitions(-D_WINDOWS)
	elseif (${sub} STREQUAL "CONSOLE")
		add_definitions(-D_CONSOLE)
	endif ()
endfunction ()

# must use to after project making
function (set_working_dir module)
	set_target_properties(${module} PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "$(OutDir)")
endfunction ()

function (make_executable name system)
	add_executable(${name})
	install(TARGETS	${name}
		DESTINATION	${CMAKE_INSTALL_PREFIX}
	)
	subsystem(${name} ${system})
	set_working_dir(${name})
endfunction ()

function (make_library name type)
	string(TOUPPER ${type} ${type})
	add_library(${name} ${type})

	if (${type} STREQUAL "SHARED")
		install(TARGETS	${name}
			DESTINATION	${CMAKE_INSTALL_PREFIX}
		)
		subsystem(${name} "WINDOWS")
	endif ()
	set_working_dir(${name})
endfunction ()

function(set_pch target src header)
	if (NOT ${CMAKE_GENERATOR} MATCHES "Visual Studio")
		# Now only support precompiled headers for the Visual Studio projects
		return()
	endif ()

	#message("Enable PCH for ${target}")
	set(pch_file "$(IntDir)$(TargetName).pch")

	set_source_files_properties("${src}" PROPERTIES COMPILE_FLAGS " /Yc${header} /Fp${pch_file} ")
	target_compile_options(${target}
		PUBLIC
			/Yu${header}
			/Fp${pch_file}
	)
endfunction()

function (unset_pch)
	if (NOT ${CMAKE_GENERATOR} MATCHES "Visual Studio")
		# Now only support precompiled headers for the Visual Studio projects
		return()
	endif ()

	set_property(SOURCE ${ARGN} APPEND PROPERTY COMPILE_FLAGS "/Y-")
endfunction ()

function (add_sources target group)
	set(source ${ARGN})

	source_group(${group} FILES ${source})
	target_sources(${target} PRIVATE ${source})
endfunction ()

function (add_sources_no_pch target group)
	add_sources(${target} ${group} ${ARGN})
	unset_pch(${ARGN})
endfunction ()

function (add_pch target src header)
	set(sources
		${src}
		${header}
	)
	add_sources(${target} "pch" ${sources})
	set_pch(${target} ${src} ${header})
endfunction ()

function (add_and_link_dependency target dependency)
	add_dependencies(${target} ${dependency})

	target_link_libraries(${target}
		PUBLIC
			"${dependency}.lib"
	)
endfunction ()
