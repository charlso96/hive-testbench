#include "hdfs.h"
#include <iostream>
#include <string>
#include <fstream>
#include <chrono>

void usage() {
    std::cout << "listfiles <output_path>\n"; 
}


int main(int argc, char ** argv) {    
    if (argc != 2) {
        usage();
    }
    std::string fs_path = "hdfs://ec2-3-14-87-138.us-east-2.compute.amazonaws.com";

    std::string output_path = argv[1];
    hdfsFS fs = hdfsConnect(fs_path.c_str(), 8020);

    std::string orders_path = "/user/hive/warehouse/tpch_partitioned_orc_4.db/orders";
    std::string lineitem_path = "/user/hive/warehouse/tpch_partitioned_orc_4.db/lineitem";

    hdfsFileInfo * orders_parts;
    hdfsFileInfo * lineitem_parts;
    int orders_parts_size = 0;
    int lineitem_parts_size = 0;
    orders_parts = hdfsListDirectory(fs, orders_path.c_str(), &orders_parts_size);
    lineitem_parts = hdfsListDirectory(fs, lineitem_path.c_str(), &lineitem_parts_size);
    int part_list_size = 0;
    hdfsFileInfo * part_list;
    std::ofstream output_file;
    output_file.open(output_path);
    for (int i = 0; i < 9; i++){
        for (int j = 0; j < orders_parts_size; j++) {
            auto start = std::chrono::high_resolution_clock::now();
            part_list = hdfsListDirectory(fs, &(orders_parts[j].mName[fs_path.size() + 5]), &part_list_size); 
            auto end = std::chrono::high_resolution_clock::now();
            long long microseconds = std::chrono::duration_cast<std::chrono::microseconds>(
            end - start).count();
            output_file << microseconds << "\n";
            hdfsFreeFileInfo(part_list, part_list_size);
        }

        for (int j = 0; j < lineitem_parts_size; j++) {
            auto start = std::chrono::high_resolution_clock::now();
            part_list = hdfsListDirectory(fs, &(lineitem_parts[j].mName[fs_path.size() + 5]), &part_list_size);
            auto end = std::chrono::high_resolution_clock::now();
            long long microseconds = std::chrono::duration_cast<std::chrono::microseconds>(
            end - start).count();
            output_file << microseconds << "\n";
            hdfsFreeFileInfo(part_list, part_list_size);

        }
    }
    hdfsFreeFileInfo(orders_parts, orders_parts_size);
    hdfsFreeFileInfo(lineitem_parts, lineitem_parts_size);

    return 0;

}
