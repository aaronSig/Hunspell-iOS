lib_LTLIBRARIES = libhunspell-1.3.la
libhunspell_1_3_includedir = $(includedir)/hunspell
libhunspell_1_3_la_SOURCES=affentry.cxx affixmgr.cxx csutil.cxx \
		     dictmgr.cxx hashmgr.cxx hunspell.cxx \
	             suggestmgr.cxx license.myspell license.hunspell \
	             phonet.cxx filemgr.cxx hunzip.cxx replist.cxx

libhunspell_1_3_include_HEADERS=affentry.h htypes.h affixmgr.h \
	        csutil.h hunspell.h atypes.h dictmgr.h hunspell.h \
		suggestmgr.h baseaffix.h hashmgr.h langnum.h \
		phonet.h filemgr.h hunzip.h w_char.h replist.h \
		hunvisapi.h

libhunspell_1_3_la_DEPENDENCIES=utf_info.cxx
libhunspell_1_3_la_LDFLAGS=-no-undefined

AM_CXXFLAGS=$(CFLAG_VISIBILITY) -DBUILDING_LIBHUNSPELL

EXTRA_DIST=hunspell.dsp makefile.mk README utf_info.cxx
