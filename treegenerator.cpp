#include "treegenerator.h"
#include <cstdlib>

constexpr float spawnProbability = 0.42f;
constexpr float speed = 2.5f;

TreeGenerator::TreeGenerator(QObject *parent)
    : Generator{parent}
{

}

void TreeGenerator::setTime(qreal time)
{
    this->time = time;

    for(int i = trees.size() - 1; i >= 0; --i)
    {
        trees[i]->setX(trees[i]->getX() - speed);
        if(trees[i]->getX() < -10)
        {
            Tree* tree = trees[i];
            trees.remove(i);
            tree->deleteLater();
        }
    }

    if(std::rand() < ((float) RAND_MAX * spawnProbability))
    {
//        qDebug() << "add tree";
//        trees.append(QPointF(width, 0));
        int maxHeight = 200;
        int minHeight = 120;

        qreal height = minHeight + std::rand() % maxHeight + 1 - minHeight;
        qreal width = height / 2;
        trees.append(new Tree(this->width + 50, height, width));
    }
    emit dataChanged();
}

QVector<QPointF> TreeGenerator::getData()
{
    return data;
}
