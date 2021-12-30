#include "generator.h"
#include "SimplexNoise/src/SimplexNoise.h"
#include <QDebug>

Generator::Generator(QObject *parent)
    : QObject{parent}
{
}

QVector<qreal> Generator::getData()
{
    QVector<qreal> data;
    for(int i = minimum; i < maximum; ++i)
    {
        float val = i / 100.0;
        data.append(SimplexNoise::noise(val));
    }
    return data;
}
