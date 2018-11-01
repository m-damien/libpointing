#include <fstream>
#include <iostream>
#include <vector>
#include <pointing-win/transferfunctions/WindowsFunction.h>


struct DataRow
{
    int countX;
    int countY;
    int screenX;
    int screenY;
    int guessX;
    int guessY;
    int matlabX;
    int matlabY;
};


void DisplayMyURI (pointing::URI &uri)
{
    std::cout << "scheme: " << uri.scheme << ", opaque: " << uri.opaque << std::endl;
    int slider;
    pointing::URI::getQueryArg(uri.query, "slider", &slider);
    std::cout << "Query(slider): " << slider << std::endl;
}


void UnitTest_One2Three (pointing::TransferFunction *tf, int max, bool negative)
{
    int step = negative ? -1 : 1;
    if (max * negative < 0)
    {
        std::cout << "Error: Max value is no the same sign than negative boolean." << std::endl;
        return;
    }
    int dx, dy;
    for (int i = step; i!=max; i+=step)
    {
        tf->applyi (i, i, &dx, &dy);
        std::cout << "(" << i << ", " << i << ") --> ";
        std::cout << "(" << dx << ", " << dy << ")" << std::endl;
    }
}


void ReadCSVtoVector (std::string filename, std::vector<DataRow> &out)
{
    std::ifstream fileStream;
    fileStream.open (filename);
    if (fileStream.is_open())
    {
        std::string line;
        size_t pos;
        int values[6];
        int index;
        while (std::getline (fileStream, line))
        {
            pos = 0;
            index = 0;
            while ((pos = line.find(',')) != std::string::npos)
            {
                values[index++] = atoi(line.substr(0, pos).c_str());
                line.erase(0, pos+1);
            }
            values[index] = atoi(line.c_str());
            out.push_back (DataRow {values[0], values[1], values[2], values[3], 0, 0, values[4], values[5]});
        }
        fileStream.close();
    }
    else
    {
        std::cout << "Error: Can't open file '" << filename << "'" << std::endl;
    }
}


int main (int /*argc*/, char **argv)
{
    // Args : windowsTFTest slider=[-5:5] epp=[1|0]
    std::string szURI ("windows:7?");
    szURI += "slider=" + std::string(argv[1]);
    szURI += "&epp=" + std::string(argv[2]);
    pointing::URI uri (szURI);
    pointing::PointingDevice *device = pointing::PointingDevice::create ("any:?debugLevel=1");
    pointing::DisplayDevice *display = pointing::DisplayDevice::create ("any:?debugLevel=1");
    //DisplayMyURI (uri);
    pointing::TransferFunction *testWindowsFunction = pointing::TransferFunction::create (uri, device, display);

    std::cout << "Pointing : " << device->getURI().asString() << std::endl;
    std::cout << "Display  : " << display->getURI().asString() << std::endl;
    std::cout << "FT       : " << testWindowsFunction->getURI(true).asString() << std::endl;
    std::cout << "Count XY --> dXY" << std::endl;

    std::vector<DataRow> data;
    ReadCSVtoVector ("data.csv", data);
    int last[4] = {0, 0, 0, 0};
    for (std::vector<DataRow>::iterator it = data.begin(); it != data.end(); it++)
    {
        testWindowsFunction->applyi (it->countX, it->countY, &it->guessX, &it->guessY);
        last[0] = it->screenX - last[2];
        last[1] = it->screenY - last[3];
        std::cout << "[" << it->screenX << ", " << it->screenY << "] : (" << last[0] << ", ";
        std::cout << last[1] << ") -> (" << it->guessX << ", " << it->guessY << ") / (";
        std::cout << it->matlabX << ", " << it->matlabY << ")" << std::endl;
        last[2] = it->screenX;
        last[3] = it->screenY;
    }

    return 0;
}
