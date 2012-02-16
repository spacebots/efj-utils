// $Id: eig3RecOne.cpp,v 1.4 2012/02/16 17:23:45 david Exp $
//
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
// $Log: eig3RecOne.cpp,v $
// Revision 1.4  2012/02/16 17:23:45  david
// Included CSU-compatible training.
//
// Revision 1.3  2011/07/22 14:44:50  david
// Minor cleanup.
//
// Revision 1.2  2011/07/22 14:24:40  ferreira
// Added Copyright comment
//

#include <iostream>
#include <efj/Database.h>

int main(int argc, char *argv[]) {

  if (argc != 3) {
    std::cerr << "Usage: " << argv[0] << "  database image" << std::endl;
    exit(1);
  }

  std::string database = argv[1], image = argv[2];

  efj::Database efjdb;
  efjdb.read(database);

  Eigen::VectorXd testImg;
  efjdb.readSingleFile(image.c_str(), testImg);

  Eigen::VectorXd projection, distances, results;
  efjdb.project_single_image(testImg, projection);
  efjdb.compute_distance_to_groups(projection, distances, results);

  std::cerr << "DISTANCES: \n" << distances << std::endl;
  std::cerr << "RESULTS: \n";
  for (int rx = 0; rx < results.rows(); rx++)
    if (results(rx) != 0) std::cout << rx << ": " << results(rx) << std::endl;

}

