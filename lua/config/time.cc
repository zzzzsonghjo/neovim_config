#include <cstdlib>
#include <ctime>
#include <iostream>
#include <ostream>
#include <string>

int main(int argc,char *argv[]){
	if(argc==1){
		std::cerr<<"ERROR: "<<"need one arguments"<<std::endl;
		return 1;
	}
	std::string command;
	for(int i=1;i<argc;i++){
		command+=argv[i];
		command+=' ';
	}
	auto st=clock();
	auto ret=system(command.c_str());
	auto ed=clock();
	std::cout<<std::endl<<"\033[0m";
	std::cout<<"[time "<<(double)(ed-st)/1000<<"s";
	std::cout<<" with code "<<ret<<"]"<<std::endl;
	return 0;
}
