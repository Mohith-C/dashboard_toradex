#include <QPaintEvent>
#include <QPainter>
#include <QPen>
#include "powerring.h"

PowerRing::PowerRing(QQuickItem *parent)
    : QQuickPaintedItem(parent)
{

}
// Start Angle
void PowerRing::setStartAngle(int stAngle)
{
    m_startAngle = stAngle;
}
int PowerRing::getStartAngle() const
{
    return m_startAngle;
}

// Span Angle
void PowerRing::setSpanAngle(int spAngle)
{
    m_spanAngle = spAngle;
    emit spanAngleChanged (m_spanAngle);
    update();
}

int PowerRing::getSpanAngle() const
{
    return m_spanAngle;
}

// Overlapping circle thickness
void PowerRing::setThickness(int thickness)
{
    m_thickness = thickness;
}

int PowerRing::getThickness() const
{
    return m_thickness;
}



void PowerRing::geometryChanged(const QRectF &newGeometry, const QRectF &oldGeometry)
{

    const QRectF bounds(0, 0, width(), height());
    QPen pen;
    pen.setCapStyle(Qt::RoundCap);
    pen.setWidth(m_thickness);

    m_gradient.setStart(bounds.width() / 2, 0);
    m_gradient.setFinalStop(bounds.width() / 2, bounds.height());
    m_gradient.setColorAt(0, "black");

    //don't forget to forward the invocation to the parent
    QQuickPaintedItem::geometryChanged(newGeometry, oldGeometry);
}

void PowerRing::paint(QPainter *painter)
{
        painter->setRenderHints(QPainter::TextAntialiasing | QPainter::Antialiasing |
                            QPainter::HighQualityAntialiasing | QPainter::SmoothPixmapTransform);

        const QRectF bounds(0, 0, width(), height());

        QPen pen;
        pen.setCapStyle(Qt::FlatCap);
        pen.setWidth(m_thickness);

        QBrush brush(m_gradient);
        pen.setBrush(brush);
        painter->setPen(pen);

        //This calculation is based on power ring starting position.
        if(m_spanAngle<214)
        {
             painter->drawArc(bounds,213*16,(147+m_spanAngle)*16);
        }
        else
        {
             painter->drawArc(bounds,213*16,-m_spanAngle*16);
        }

}
