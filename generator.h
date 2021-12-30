#pragma once

#include <QObject>

class Generator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector<qreal> data READ getData NOTIFY dataChanged)
    Q_PROPERTY(qreal minimum READ getMinimum WRITE setMinimum NOTIFY minimumChanged)
    Q_PROPERTY(qreal maximum READ getMaximum WRITE setMaximum NOTIFY maximumChanged)

public:
    explicit Generator(QObject *parent = nullptr);

    Q_INVOKABLE QVector<qreal> getData();
    Q_INVOKABLE qreal getMinimum() { return minimum; }
    Q_INVOKABLE void setMinimum(qreal minimum) { this->minimum = minimum; emit minimumChanged(); }
    Q_INVOKABLE qreal getMaximum() { return maximum; }
    Q_INVOKABLE void setMaximum(qreal maximum) { this->maximum = maximum; emit maximumChanged(); }

signals:
    void minimumChanged();
    void maximumChanged();
    void dataChanged();

private:
    qreal minimum = 0;
    qreal maximum = 0;
};
