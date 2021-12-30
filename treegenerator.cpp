#include "treegenerator.h"
#include <cstdlib>

constexpr float treeProbability = 0.2f;

TreeGenerator::TreeGenerator(QObject *parent)
    : Generator{parent}
{

}

void TreeGenerator::setTime(qreal time)
{
    qDebug() << "set time";
    this->time = time;

    for(int i = data.size() - 1; i >= 0; --i)
    {
        data[i].setX(data[i].x() - 10);
        if(data[i].x() < -100)
        {
            data.remove(i);
        }
    }

    if(std::rand() < ((float) RAND_MAX * treeProbability))
    {
        qDebug() << "add tree";
        data.append(QPointF(width, 0));
    }
    emit dataChanged();
}

QVector<QPointF> TreeGenerator::getData()
{
    return data;
}
