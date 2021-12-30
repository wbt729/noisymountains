#pragma once

#include <QObject>
#include <QDebug>
#include "generator.h"

class Tree : public QObject
{
    Q_OBJECT

    Q_PROPERTY(qreal height READ getHeight)
    Q_PROPERTY(qreal width READ getWidth)
    Q_PROPERTY(qreal x READ getX)

public:
    Q_INVOKABLE qreal getHeight() { return height; }
    Q_INVOKABLE qreal getWidth() { return width; }
    Q_INVOKABLE qreal getX() { return x; }

    Tree(qreal x, qreal height, qreal width) : x(x), height(height), width(width) {}

    void setX(qreal x) { this->x = x; }

private:
    qreal height = 0;
    qreal width = 0;
    qreal x = 0;
};

class TreeGenerator : public Generator
{
    Q_OBJECT
public:
    explicit TreeGenerator(QObject *parent = nullptr);
    Q_INVOKABLE void setTime(qreal time) override;
    Q_INVOKABLE QVector<QPointF> getData() override;

signals:

private:
    QVector<Tree*> trees;

};
