// Copyright (C) 2008-2011 INESC ID Lisboa.
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
//
// $Log: trainAndWriteCSUCompatible.cpp,v $
// Revision 1.3  2012/02/18 16:01:15  ferreira
// *** empty log message ***
//
// Revision 1.2  2012/02/16 23:54:27  ferreira
// added use of a compute_eigenfaces that does not filter eigenvalues and eigenvectors
//
// Revision 1.1  2012/02/12 02:05:51  ferreira
// Added CSUFaceIDEvalSystem compatible output
//

#include <iostream>
#include "Database.h"


int main(int argc, char *argv[]) {
  std::string dir;
  std::string database;
  int nSubjects = 1;

  if (argc == 4) {
    dir = argv[2];
    database = argv[3];
    nSubjects = strtol(argv[1], NULL, 10);
  } else {
    std::cerr << "Usage: " << argv[0] << " images_per_subject directory_name database_name" << std::endl;
    exit(1);
  }





  efj::Database db(dir, nSubjects);
  db.compute_eigenfaces_NO_FILTERING();
  //db.project_clusters();
  db.writeSubspace(database);
}
