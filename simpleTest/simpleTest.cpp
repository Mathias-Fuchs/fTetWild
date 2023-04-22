// simpleTest.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>

#define CAPIONLY
#include <floattetwild/FloatTetwild.h>
#include <Eigen/Dense>

int main()
{
    floatTetWild::Parameters p;
	std::vector<double> verts = { 0,0,0,1,0,0,1,1,0,0,0,1 };
	std::vector<size_t> tris    = { 0,1,2, 0,1,3,0,2,3,1,2,3 };
	const Eigen::MatrixXd* v;
	const Eigen::MatrixXi* t;
    floatTetWild::tetrahedralizationFlat(verts.size() / 3, verts.data(), tris.size() / 3, tris.data(), &p, (void**) & v, (void**) & t, -1, false);
	const Eigen::MatrixXd& VO = *v;
	const Eigen::MatrixXi& TO = *t;
	std::vector<double> vertsOUt(VO.data(), VO.data() + VO.innerStride() * VO.outerStride());
	std::vector<int> tetsOut(TO.data(), TO.data() + TO.innerStride() * TO.outerStride());
	std::cout << std::endl;
	for (int i = 0; i < 4; i++) 
		std::cout << "produced vert " << i << ": " << VO(i, 0) << " " << VO(i, 1) << " " << VO(i, 2) << std::endl;

	for (int i = 0; i < TO.outerSize(); i++) {
		if (i >= 10) break;
		std::cout << "produced tet " << i << ": " << TO(i, 0) << " " << TO(i, 1) << " " << TO(i, 2) << " " << TO(i, 3) << std::endl;
	}
	std::cout << std::endl;
	floatTetWild::tetrahedralizationClean((void*)v, (void*)t);
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
