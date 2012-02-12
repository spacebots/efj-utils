# $Id: Makefile,v 1.3 2012/02/12 02:05:51 ferreira Exp $
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
# Revision 1.3  2012/02/12 02:05:51  ferreira
# Added CSUFaceIDEvalSystem compatible output
#
# Revision 1.2  2011/07/22 14:44:50  david
# Minor cleanup.
#
#
CC = g++
#32bit
#QTDIR=/usr/lib/qt4
#64bit
QTDIR=/usr/lib64/qt4
INCLUDEDIR=/usr/include
#EIGEN=/afs/l2f.inesc-id.pt/home/ferreira/face-recognition/eigen
EIGEN=$(INCLUDEDIR)/eigen3

CLASSES = 
PROGRAMS = eig3Train eig3Rec eig3RecOne eig3RecOnePickOne createDatabaseTester

SRCFILES = $(CLASSES:%=%.cpp) $(PROGRAMS:%=%.cpp)
OCLASSES = $(CLASSES:%=%.o)
OFILES = $(PROGRAMS:%=%.o) $(OCLASSES)

LIBEFJDIR = ${HOME}/workspace/efj

# 32bit
#BASE_CXXFLAGS = -I$(EIGEN) -I$(QTDIR)/include/QtCore/ -I$(QTDIR)/include/QtGui -DPIC -fPIC -m32 -pipe 
# 64bit
BASE_CXXFLAGS = -I. -I$(LIBEFJDIR) -I$(EIGEN) -I$(QTDIR)/include/QtCore/ -I$(QTDIR)/include/QtGui -DPIC -fPIC -m64 -pipe 
# 32bit vanilla
#CXXFLAGS = $(BASE_CXXFLAGS) -DNDEBUG -DEIGEN_NO_DEBUG -O3 -fmessage-length=0 -Wall -D_FORTIFY_SOURCE=2 -fstack-protector -funwind-tables -fasynchronous-unwind-tables -D_REENTRANT -fopenmp

# optimize
#CXXFLAGS = $(BASE_CXXFLAGS) -DDEBUG -DNDEBUG -DEIGEN_NO_DEBUG -O3 -msse2 -msse3 -mssse3 -msse4 -msse4.1 -msse4.2 -fmessage-length=0 -Wall -D_FORTIFY_SOURCE=2 -fstack-protector -funwind-tables -fasynchronous-unwind-tables -D_REENTRANT -fopenmp
# debug
CXXFLAGS = $(BASE_CXXFLAGS) -ggdb -Wall -DDEBUG -D_FORTIFY_SOURCE=2 -funwind-tables -fasynchronous-unwind-tables -D_REENTRANT 

LDFLAGS = -L$(LIBEFJDIR) -lefj -lboost_filesystem -lQtGui -lgomp -lboost_system -lQtCore

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
	
