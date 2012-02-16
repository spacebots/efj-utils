# $Id: Makefile,v 1.4 2012/02/16 17:23:45 david Exp $
#
# Copyright (C) 2008-2011 INESC ID Lisboa.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
# $Log: Makefile,v $
# Revision 1.4  2012/02/16 17:23:45  david
# Included CSU-compatible training.
#
# Revision 1.3  2012/02/12 02:05:51  ferreira
# Added CSUFaceIDEvalSystem compatible output
#
# Revision 1.2  2011/07/22 14:44:50  david
# Minor cleanup.
#
#
CC = g++

#32bit
#LIBDIR=/usr/lib
#64bit
LIBDIR=/usr/lib64

QTDIR=$(LIBDIR)/qt4
INCLUDEDIR=/usr/include
EIGEN=$(INCLUDEDIR)/eigen3

CLASSES = 
PROGRAMS = eig3Train eig3Rec eig3RecOne eig3RecOnePickOne createDatabaseTester trainAndWriteCSUCompatible

SRCFILES = $(CLASSES:%=%.cpp) $(PROGRAMS:%=%.cpp)
OCLASSES = $(CLASSES:%=%.o)
OFILES = $(PROGRAMS:%=%.o) $(OCLASSES)

LIBEFJ_LIB = $(LIBDIR)
LIBEFJ_INC = $(INCLUDEDIR)

LIBEFJDIR = ../efj

# for development purposes (if you are developing both libefj and this project)
# otherwise: comment these two lines
LIBEFJ_LIB = $(LIBEFJDIR)
LIBEFJ_INC = $(LIBEFJDIR)

BASE_CXXINC = -I. -I$(LIBEFJDIR) -I$(EIGEN) -I$(QTDIR)/include/QtCore/ -I$(QTDIR)/include/QtGui
#debug
#BASE_CXXDEBUG =-DDEBUG -ggdb  -D_FORTIFY_SOURCE=2 -funwind-tables -fasynchronous-unwind-tables -D_REENTRANT
#optimize 
BASE_CXXDEBUG = -DNDEBUG -DEIGEN_NO_DEBUG -O3 -msse2 -msse3 -mssse3 -msse4 -msse4.1 -msse4.2 -fmessage-length=0 -D_FORTIFY_SOURCE=2 -fstack-protector -funwind-tables -fasynchronous-unwind-tables -D_REENTRANT -fopenmp
BASE_CXXOTHER = -Wall -DPIC -fPIC -pipe

# 32bit
#CXXFLAGS += -m32 $(BASE_CXXINC) $(BASE_CXXDEBUG) $(BASE_CXXOTHER)
# 64bit
CXXFLAGS += -m64 $(BASE_CXXINC) $(BASE_CXXDEBUG) $(BASE_CXXOTHER)

LDFLAGS = -L$(LIBEFJ_LIB) -lefj -lboost_filesystem -lgomp -lboost_system -lQtGui -lQtCore

all: $(PROGRAMS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -o $@ -c $<

%: %.o
	$(CXX) -o $@ $< $(LDFLAGS)

clean: 
	$(RM) $(PROGRAMS) $(OFILES)
	
depend:
	$(CXX) $(CXXFLAGS) -MM $(SRCFILES) > .makedeps

-include .makedeps
	
